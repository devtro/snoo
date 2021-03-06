module Snoo
  # Methods for moderating on reddit, including tasks such as removing, approving, and distinguishing
  #
  # @author (see Snoo)
  module Moderation

    # Approve a thing
    #
    # @param id [String] Thing targeted
    # @return (see #clear_sessions)
    def approve id
      logged_in?
      post('/api/approve', body: {id: id, uh: @modhash})
    end

    # Distinguish a thing
    #
    # @param (see #approve)
    # @param how [yes, no, admin, special] Determines how to distinguish something. Only works for the permissions you have.
    # @return (see #clear_sessions)
    def distinguish id, how
      logged_in?
      hows = %w{yes no admin special}
      raise ArgumentError, "how should be one of #{hows * ', '}, is #{how}" if hows.include?(how)
      post('/api/distinguish', body: {id: id, how: how, uh: @modhash})
    end

    # Removes you from a subreddits list of contributors
    # @note (see #clear_sessions)
    #
    # @param id [String] The subreddit id
    # @return (see #clear_sessions)
    def leave_contributor id
      logged_in?
      post('/api/leavecontributor', body: {id: id, uh: @modhash})
    end

    # Removes you from a subreddits moderators
    # @note (see #clear_sessions)
    #
    # @param (see #leave_contributor)
    # @return (see #clear_sessions)
    def leave_moderator id
      logged_in?
      post('/api/leavemoderator', body: {id: id, uh: @modhash})
    end

    # Removes a thing
    #
    # @param (see #approve)
    # @param spam [true, false] Mark this removal as a spam removal (and train the spamfilter)
    # @return (see #clear_sessions)
    def remove id, spam
      logged_in?
      spams = [true, false]
      raise ArgumentError, "spam should be boolean, is #{spam}" unless spams.include?(spam)
      post('/api/remove', body: {id: id, spam: spam, uh: @modhash})
    end

  end
end
