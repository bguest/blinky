class EffectsController < ApplicationController

  def index
    @effects = Effect.all
    @new_effect = Effect.new
  end

  def create
    effect = Effect.new(effect_params)

    if effect.save
      flash[:success] = 'Effect created successfully'
      redirect_to edit_instruction_path(effect.instruction_id)
    else
      flash[:error] = 'Effect could not be created'
      render :index
    end
  end

  def edit
    @effect = Effect.find(params[:id])
  end

  def update
    effect = Effect.find(params[:id])
    type = effect.type
    if effect.update_attributes(effect_params)
      flash[:success] = "Effect #{type} updated"
      redirect_to edit_instruction_path(effect.instruction_id)
    else
      flash[:error] = "Error updating effect #{type}"
      render :index
    end
  end

  #DELETE /letters/:id(.:format)      letters#destroy
  def destroy
    effect = Effect.find(params[:id])
    type = effect.type
    instruction_id = effect.instruction_id
    if effect.destroy
      flash[:success] = "Effect #{type} deleted"
      redirect_to edit_instruction_path(instruction_id)
    else
      flash[:error] = "Problem deleting Effect #{type}"
      render :index
    end
  end

  private

  def effect_params
    params.require(:effect).permit!
  end

end

