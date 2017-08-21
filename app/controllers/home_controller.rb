class HomeController < ApplicationController

  def dashboard
    if current_user.user_type == "admin"
      redirect_to "/admin"
      return
    else
      @t_type = params[:type].present? ? params[:type] : "my"
      if @t_type == "my"
        @tickets = current_user.tickets
      elsif @t_type == "pending"
        @tickets = Ticket.where(:status => "new")
      elsif @t_type == "closed"
        @tickets = Ticket.where(:status => "closed")
      elsif @t_type == "answerd_byme"
        @t_type = "Responded by me"
      end
    end
  end

  def ticket_detail
    @ticket = Ticket.find_by_id(params[:id])
    @new_comment    = Comment.build_from(@ticket, current_user.id, "")
  end

  def create_ticket
  	@ticket = Ticket.new
  end

  def save_ticket
  	@ticket = Ticket.new(ticket_params)
    @ticket.status = "new"
  	@ticket.save
    ticket_no = "Tickt#{@ticket.id}-#{SecureRandom.hex 4}"
    @ticket.ticket_no = ticket_no
    @ticket.save
  	flash[:notice] = "Ticket created successfully."
    redirect_to "/tickets/my"
  end

  def save_comment
    commentable = commentable_type.constantize.find(commentable_id)
    commentable.status = "responded"
    commentable.save
    @comment = Comment.build_from(commentable, current_user.id, body)
    @comment.save
    make_child_comment
    redirect_to "/ticket_detail/#{commentable_id}"
  end
  private
    def ticket_params
      params.require(:ticket).permit(:email, :user_id, :subject, :message)
    end
    def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type, :comment_id)
  end

  def commentable_type
    comment_params[:commentable_type]
  end

  def commentable_id
    comment_params[:commentable_id]
  end

  def comment_id
    comment_params[:comment_id]
  end

  def body
    comment_params[:body]
  end

  def make_child_comment
    return "" if comment_id.blank?

    parent_comment = Comment.find comment_id
    @comment.move_to_child_of(parent_comment)
  end
end
