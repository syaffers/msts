class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :destroy, :update]
  before_action :authenticate_admin!, only: [:new, :create, :destroy]

  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = Ticket.all
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    if(params[:sn].nil?)
      @ticket = Ticket.new
    else
      @ticket = Ticket.new(:serial_number => params[:sn])
    end
    @students_array = Student.all
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)
    number = params[:ticket_qty].to_i
    @tickets = Array.new
    number.times do |n|
      t = Ticket.new(ticket_params)
      t.serial_number = t.serial_number.to_i + n
      @tickets.push(t)
    end

    ActiveRecord::Base.transaction do 
      @save_results = @tickets.map &:save
      raise ActiveRecord::Rollback unless @save_results.all? 
    end

    respond_to do |format|
      if @save_results.all? 
        format.html { redirect_to tickets_path, notice: "#{number} #{"ticket".pluralize(number)} successfully created." }
        format.js do 
          flash[:notice] = "#{number} #{"ticket".pluralize(number)} successfully created."
          flash.keep(:notice)
          render :js => "window.location.replace('#{tickets_path}');"
        end
        format.json { render :show, status: :created, location: tickets_path }
      else
        format.html do
          render :new
        end
        format.js {}
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: 'Status changed.' }
        format.js {}
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def qr
    serial = params[:c].scan(/[A-Z]+|\d+/)[1].to_i

    correct_code = params[:c].scan(/[A-Z]+|\d+/)[0].eql? "MUS"
    correct_serial = serial < 150000 && serial > 139999
    if correct_code
      ticket = Ticket.find_by("serial_number = ?", serial)
    end

    respond_to do |format|
      if !correct_code || !correct_serial
        format.html { redirect_to tickets_path, notice: "Invalid QR code" }
      elsif ticket.nil?
        format.html { redirect_to(:controller => "tickets", :action => "new", :sn => serial)  }
      else
        format.html { redirect_to ticket, notice: 'Ticket is already registered' }
        format.json { render :show, location: ticket }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:serial_number, :student_id, :event_id, :member, :attendance)
    end
end
