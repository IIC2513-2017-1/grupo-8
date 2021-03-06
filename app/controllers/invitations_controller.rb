class InvitationsController < ApplicationController
  before_action :is_current_user?, only: %i[create]



  def create

    @invitations = Invitation.new(invitation_params) # Make a new Invite
    emails =  @invitations.email.delete('  ').split(',')

    @invalids = []
    @invitations_count = 0
    emails.each do |email|
      if validate_email(email)
        @invitation = Invitation.new(email: email, team_id: params[:invitation][:team_id], is_captain:params[:invitation][:is_captain])
        @invitation.sender_id = current_user.id
        if @invitation.save
          @invitations_count += 1
          Mailer.invitation_mail(@invitation, new_user_registration(@invitation.token)).deliver_now
        else
          @invalids.append(email)
          # oh no, creating an new invitation failed
        end
      else
        @invalids.append(email)
      end
    end
    respond_to do |format|
      format.js
    end
  end

  private

    def invitation_params
      params.require(:invitation).permit(:email, :team_id, :is_captain)
    end

   def new_user_registration(token)
     if Rails.env == 'development'
       return "http://localhost:3000/signup?invitation_token=#{token}"
     elsif Rails.env == 'production'
       return "http://laliga.herokuapp.com/signup?invitation_token=#{token}"
     end

   end

   def is_current_user?
     redirect_to(root_path, notice: 'No autorizado a agregar jugadores!') unless (
                (current_user.team.id == Integer(invitation_params[:team_id]) && current_user.is_captain?) || is_admin_logged_in? )
   end

   def validate_email(value)
     value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
   end

end

#http://localhost:3000/signup?invitation_token=7f3603fe4f9cef8cde1572eb3a04d52b0485743e
