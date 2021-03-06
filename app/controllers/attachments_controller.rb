class AttachmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_attachment, only: [:show, :edit, :update, :destroy]

  # GET /attachments
  # GET /attachments.json
  def index
    @attachments = Attachment.all
    if params.has_key?(:expiring)
      @attachments = Attachment.expiring_in(eval("#{params[:expiring]}.days"))
    end
  end

  # GET /attachments/1
  # GET /attachments/1.json
  def show
  end

  # GET /attachments/new
  def new
    @attachment = Attachment.new
  end

  # GET /attachments/1/edit
  def edit
  end

  # POST /attachments
  # POST /attachments.json
  def create
    date_of_issue = Date.strptime attachment_params[:date_of_issue], "%m/%d/%Y"
    date_of_expiry = Date.strptime attachment_params[:date_of_expiry], "%m/%d/%Y"
    @attachment = Attachment.new(attachment_params)
    @attachment.date_of_issue = date_of_issue
    @attachment.date_of_expiry = date_of_expiry
    respond_to do |format|
      if @attachment.save
        format.html { redirect_to @attachment, notice: 'Attachment was successfully created.' }
        format.json { render :show, status: :created, location: @attachment }
      else
        format.html { render :new }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attachments/1
  # PATCH/PUT /attachments/1.json
  def update
    date_of_issue = Date.strptime attachment_params[:date_of_issue], "%m/%d/%Y" if !attachment_params[:date_of_issue].blank?
    date_of_expiry = Date.strptime attachment_params[:date_of_expiry], "%m/%d/%Y"
    respond_to do |format|
      if @attachment.update(attachment_params)
        @attachment.date_of_issue = date_of_issue
        @attachment.date_of_expiry = date_of_expiry
        @attachment.save!
        format.html { redirect_to @attachment, notice: 'Attachment was successfully updated.' }
        format.json { render :show, status: :ok, location: @attachment }
      else
        format.html { render :edit }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attachments/1
  # DELETE /attachments/1.json
  def destroy
    @attachment.destroy
    respond_to do |format|
      format.html { redirect_to attachments_url, notice: 'Attachment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attachment
      @attachment = Attachment.find(params[:id])
      @attachment.long_name = "#{@attachment.name} - #{@attachment.owner_name}"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attachment_params
      params.require(:attachment).permit(:name, :driver_id, :turn_boy_id, :truck_owner_id, :truck_id, :date_of_issue, :date_of_expiry, :file)
    end
end
