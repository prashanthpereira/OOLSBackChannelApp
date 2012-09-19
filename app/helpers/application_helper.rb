require 'date'

module ApplicationHelper

  def admin?(id)

    if  User.select(:role).where(:id => current_user.id) == "admin"
      return true
    else
      return false
    end
  end

  def owner?(id)
    if current_user.id == id
      return true
    else
      return false
    end
  end

  def admin_or_owner?(id)
    if (admin?(id) || owner?(id))
      return true
    else
      return false
    end
  end


  def get_all_comments_for_post(currentpostid)
    return Post.where(:parent_id => currentpostid)
  end

  def get_all_comment_ids_for_post(currentpostid)
    comments = Array.new

    comments =  Post.where(:parent_id => currentpostid).pluck(:id)
    return comments
  end

  def get_user(userid)
    @result = User.select(:username).where(:id => userid)
     @result.each do |res|
        return res.username
      end
  end

  def get_votes_for_post(postid)
     return Vote.select(:user_id).where(:post_id => postid).count
  end

  def get_datetime_string(t)
    return t.strftime('%b %d, %Y %I:%M %p')
  end

  def set_comment_session(val)
    if (val=="true")
    session[:comment] = "true"
    else
      session[:comment] = "false"
      end
    end

  def get_comment_session()
    return session[:comment]
  end

  def get_all_posts()
    return Post.where(:parent_id => nil )
  end

  def get_all_postid_for_user(userid)
    postids = Array.new
    postids =  Post.where(:user_id => userid).pluck(:id)
    return postids
  end

  def get_vote_count(postid_array)
    values  = Array.new
    postid_array.each do |x|
      values << get_votes_for_post(x)
    end
     values.inject{|sum,y| sum + y }
  end



end
