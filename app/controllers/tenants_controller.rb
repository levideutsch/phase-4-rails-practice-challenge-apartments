class TenantsController < ApplicationController
    before_action :one_tenant, only: [:show, :destroy, :update]

    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def create 
        tenant = tenant.create!(tenant_params)
        render json: tenant, status: :created
    end

    def index 
        render json: Tenant.all 
    end

    def show
        render json: @tenant
    end

    def update 
        @tenant.update!(tenant_params)
        render json: @tenant, status: :accepted
    end

    def destroy
        @tenant.destroy
        head :no_content
    end


    private 

    def one_tenant
        @tenant = Tenant.find(params[:id])
    end


    def tenant_params
        params.permit(:name, :age) 
    end


    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end
    
    def render_not_found_response
        render json: { error: "tenant not found" }, status: :not_found
    end
end
