class RemovePdfFromResumes < ActiveRecord::Migration[6.0]
  def up
    # Get all Resume records
    resumes = Resume.all

    # Loop through each resume
    resumes.each do |resume|
      # If the resume has a pdf attached
      if resume.pdf.attached?
        # Delete the attachment
        resume.pdf.purge
      end
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end