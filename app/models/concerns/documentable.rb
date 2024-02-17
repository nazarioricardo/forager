module Documentable
  extend ActiveSupport::Concern

  def copy(company, role, doc_service)
      copy = doc_service.copy_file(
      self.google_drive_file_id, 
      "#{self.title}.pdf", 
      self.title
    )


    requests = doc_service.replace_text(
      copy.id, 
      '{{company}}', 
      company
    )

    requests += doc_service.replace_text(
      copy.id, 
      '{{role}}', 
      role
    )

    doc_service.execute_requests(copy.id, requests)

    copy
  end

  def export(copy_id, doc_service)
    doc_service.generate_pdf(copy_id)
  end

  def copy_and_export(company, role, google_token)
    doc_service = DocumentService.new(google_token)
    copy = self.copy(company, role, doc_service)
    self.export(copy.id, doc_service)
  end

  def drive_url
    "https://drive.google.com/file/d/#{self.google_drive_file_id}/view"
  end

  def docs_url
    "https://docs.google.com/document/d/#{self.google_drive_file_id}/edit"
  end
end