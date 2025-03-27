class ProfilesController < ApplicationController
  allow_unauthenticated_access only: :show

  before_action :set_profile

  def show
  end

  def edit
  end

  def update
    @profile.assign_attributes(profile_params)

    if @profile.save
      remove_profile_image_if_requested
      redirect_to profile_path(@profile.uuid), notice: t("controllers.profiles.update.success")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    user_id = @profile.profileable.id

    if @profile.profileable.destroy
      Rails.logger.info("Account deleted successfully for user ID: #{user_id}")
      redirect_to new_user_session_path, notice: t("controllers.profiles.destroy.success")
    else
      Rails.logger.error("Failed to delete account for user ID: #{user_id}, errors: #{@profile.profileable.errors.full_messages}")
      redirect_to profile_path(@profile.uuid), alert: t("controllers.profiles.destroy.error")
    end
  end

  private

  def set_profile
    @profile = Profile.find_by!(uuid: params[:uuid]).decorate
    authorize! @profile, with: ProfilePolicy
  end

  def profile_params
    params.require(:profile).permit(
      :name, :job_title, :bio, :is_public, :image,
      :twitter_url, :linkedin_url, :github_url,
      :web_push_notifications, :mail_notifications
    )
  end

  def remove_profile_image_if_requested
    @profile.image.purge if params[:profile][:remove_image].presence
  end
end
