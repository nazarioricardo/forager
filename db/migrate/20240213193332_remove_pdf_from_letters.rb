class RemovePdfFromLetters < ActiveRecord::Migration[7.1]
  def up
    # Get all Resume records
    letters = Letter.all

    # Loop through each resume
    letters.each do |letter|
      # If the resume has a pdf attached
      if letter.pdf.attached?
        # Delete the attachment
        letter.pdf.purge
      end
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
