class ApartmentsController < ApplicationController

    before_action :one_apartment, only: [:show, :destroy, :update]

    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def create 
        apartment = Apartment.create!(apartment_params)
        render json: apartment, status: :created
    end

    def index 
        render json: Apartment.all 
    end

    def show
        render json: @apartment
    end

    def update 
        @apartment.update!(apartment_params)
        render json: @apartment, status: :accepted
    end

    def destroy
        @apartment.destroy
        head :no_content
    end


    private 

    def one_apartment
        @apartment = Apartment.find(params[:id])
    end


    def apartment_params
        params.permit(:number) 
    end


    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end
    
    def render_not_found_response
        render json: { error: "Apartment not found" }, status: :not_found
    end

end
