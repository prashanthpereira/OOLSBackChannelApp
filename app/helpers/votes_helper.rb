module VotesHelper
  #get all users who have voted for a post
  def get_all_users post_id
      Vote.find(:all, :conditions => ["post_id = ?", post_id])
  end
end
