class DocumentService
  def initialize(google_token)
    @google = GoogleService.new(google_token)
  end

  def generate_pdf(file_id)
    # Copy the file and convert it to a Google Doc
    copy = @google.drive.copy_file(file_id, Google::Apis::DriveV3::File.new(mime_type: 'application/vnd.google-apps.document'))
    doc_id = copy.id

    # Replace all instances of "Ricardo" with "George"
    requests = [Google::Apis::DocsV1::Request.new(replace_all_text: Google::Apis::DocsV1::ReplaceAllTextRequest.new(contains_text: Google::Apis::DocsV1::SubstringMatchCriteria.new(text: 'Ricardo', match_case: true), replace_text: 'George'))]
    @google.docs.batch_update_document(doc_id, Google::Apis::DocsV1::BatchUpdateDocumentRequest.new(requests: requests))

    # Export the Google Doc as a PDF
    @google.drive.export_file(doc_id, 'application/pdf')
  end
end