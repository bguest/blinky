class InstructionsController < ApplicationController

  def index
    @instructions = Instruction.all
    @new_instruction = Instruction.new
  end

  def create
    instruction = Instruction.new(instruction_params)

    if instruction.save
      flash[:success] = 'Instruction created successfully'
      redirect_to edit_sequence_path(instruction.sequence_id)
    else
      flash[:error] = 'Instruction could not be created'
      render :index
    end
  end

  def edit
    @instruction = Instruction.find(params[:id])
    @effects = @instruction.effects.order(:number)
    @new_effect = Effect.new
  end

  def update
    instruction = Instruction.find(params[:id])
    phrase = instruction.phrase
    if instruction.update_attributes(instruction_params)
      flash[:success] = "Instruction #{phrase} updated"
      redirect_to edit_sequence_path(instruction.sequence_id)
    else
      flash[:error] = "Error updating instruction #{phrase}"
      render :index
    end
  end

  #DELETE /letters/:id(.:format)      letters#destroy
  def destroy
    instruction = Instruction.find(params[:id])
    phrase = instruction.phrase
    sequence_id = instruction.sequence_id
    if instruction.destroy
      flash[:success] = "Instruction #{phrase} deleted"
      redirect_to edit_sequence_path(sequence_id)
    else
      flash[:error] = "Problem deleting Instruction #{phrase}"
      render :index
    end
  end

  private

  def instruction_params
    params.require(:instruction).permit(:phrase, :duration, :sequence_id, :number)
  end

end

