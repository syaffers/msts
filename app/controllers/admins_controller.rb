class AdminsController < ApplicationController
  before_action :set_admin, only: [:edit, :edit_roles, :destroy, :update, :update_roles]
  load_and_authorize_resource

  # GET /admins
  # GET /admins.json
  def index
    @admins = Admin.where.not(id: current_admin.id)
  end

  # GET /tickets/new
  def new
    @admin = Admin.new
  end

  # POST /admins
  def create
  	@admin = Admin.new(admin_params)

	if @admin.save
	  redirect_to admins_path, notice: 'Admin was successfully created.'
	else
	  render :new
	end
  end

  # GET /admins/1/edit
  def edit
  end

  # PATCH/PUT admins/1
  def update
	if @admin.update(admin_params)
	  redirect_to admins_path, notice: 'Admin was successfully updated.'
	else
	  render :edit
	end
  end

  # GET /admins/1/edit_roles
  def edit_roles
  end

  # PATCH/PUT admins/1
  def update_roles
    @admin.roles_mask = params[:roles_mask]
    respond_to do |format|
      if @admin.save
        format.html { redirect_to admins_path, notice: 'Role changed.' }
      else
        format.html { render 'edit_roles' }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @admin.destroy
    respond_to do |format|
      format.html { redirect_to admins_url, notice: 'Admin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = Admin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      params.require(:admin).permit(:email, :password, :password_confirmation, :roles_mask)
    end
end
