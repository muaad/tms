class NotificationsController < ApplicationController
  include ActionController::Live
  before_action :set_notification, only: [:show, :edit, :update, :destroy]

  # GET /notifications
  # GET /notifications.json
  def index
    @notifications = Notification.all
  end

  # GET /notifications/1
  # GET /notifications/1.json
  def show
  end

  # GET /notifications/new
  def new
    @notification = Notification.new
  end

  # GET /notifications/1/edit
  def edit
  end

  # POST /notifications
  # POST /notifications.json
  def create
    @notification = Notification.new(notification_params)

    respond_to do |format|
      if @notification.save
        format.html { redirect_to @notification, notice: 'Notification was successfully created.' }
        format.json { render :show, status: :created, location: @notification }
      else
        format.html { render :new }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notifications/1
  # PATCH/PUT /notifications/1.json
  def update
    respond_to do |format|
      if @notification.update(notification_params)
        format.html { redirect_to @notification, notice: 'Notification was successfully updated.' }
        format.json { render :show, status: :ok, location: @notification }
      else
        format.html { render :edit }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notifications/1
  # DELETE /notifications/1.json
  def destroy
    @notification.destroy
    respond_to do |format|
      format.html { redirect_to notifications_url, notice: 'Notification was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def events
    response.headers["Content-Type"] = "text/event-stream"
    start = Time.zone.now
    10.times do |n|
      Notification.uncached do
        Notification.where('created_at > ?', start).each do |notification|
          # notification[:attachment_name] = notification.attachment_and_owner
          response.stream.write "data: #{notification.to_json}\n\n"
          start = notification.created_at
        end
      end
      sleep 2
    end

    # redis = Redis.new
    # redis.subscribe('notification.create') do |on|
    #   on.notification do |event, data|
    #     response.stream.write "data: #{data}\n\n"
    #   end
    # end
  rescue IOError
    logger.info "Stream closed"
  ensure
    response.stream.close
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = Notification.find(params[:id])
      if !@notification.attachment.nil?
        @notification.attachment_name = @notification.attachment_and_owner
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def notification_params
      params.require(:notification).permit(:attachment_id, :notification_type, :read, :resolved)
    end
end
