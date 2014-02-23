class SequencesController < ApplicationController

  def index
    @sequences = Sequence.all
    @new_sequence = Sequence.new
  end

  def create
    sequence = Sequence.new(sequence_params)
    sequence.sign = sign
    if sequence.save
      flash[:success] = 'Sequence created successfully'
      redirect_to sequences_path
    else
      flash[:error] = 'Sequence could not be created'
      @new_sequence = Sequence.new
      @sequences = Sequence.all
      render :index
    end
  end

  def edit
    @sequence = Sequence.find(params[:id])
    @instructions = @sequence.instructions.order(:number)
    @new_instruction = Instruction.new
  end

  def stop
    SequenceManager.stop
    flash[:success] = 'Sequence manager stopped'
    redirect_to edit_sequence_path(params[:id])
  end

  def start
    sequence = Sequence.find(params[:id])
    SequenceManager.run(sign, sequence )
    redirect_to edit_sequence_path(sequence)
  end

  def update
    sequence = Sequence.find(params[:id])
    name = sequence_params[:name]
    if sequence.update_attributes(sequence_params)
      flash[:success] = "Sequence #{name} updated"
      redirect_to sequences_path
    else
      flash[:error] = "Error updating sequence #{name}"
      render :index
    end
  end

  def destroy
    sequence = Sequence.find(params[:id])
    sequence = sequence_params[:name]
    if letter.destroy
      flash[:success] = "Sequence #{name} deleted"
      redirect_to sequences_path
    else
      flash[:error] = "Problem deleting Sequence #{name}"
      render :index
    end
  end

  private

  def sequence_params
    params.require(:sequence).permit(:name)
  end

end
