module Public::NotificationsHelper

  def notification_form(notification)
      @visiter = notification.visiter
      @comment = nil
      @visiter_comment = notification.comment_id
      case notification.action
        when "follow" then
          tag.a(notification.visiter.user_name, href:user_path(@visiter), style:"font-weight: bold;")+"があなたをフォローしました"
        when "memory_like" then
          tag.a(notification.visiter.user_name, href:user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの思い出投稿', href:memory_path(notification.memory_id), style:"font-weight: bold;")+"にいいねしました"
        when "hint_like" then
          tag.a(notification.visiter.user_name, href:user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたのヒント投稿', href:hint_path(notification.hint_id), style:"font-weight: bold;")+"にいいねしました"
        when "memory_comment" then
          @comment = Comment.find_by(id: @visiter_comment)&.comment
          tag.a(@visiter.user_name, href:user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの思い出投稿', href:memory_path(notification.memory_id), style:"font-weight: bold;")+"にコメントしました"
        when "hint_comment" then
          @comment = Comment.find_by(id: @visiter_comment)&.comment
          tag.a(@visiter.user_name, href:user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたのヒント投稿', href:hint_path(notification.hint_id), style:"font-weight: bold;")+"にコメントしました"
        end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
