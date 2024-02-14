class DocumentService
  def initialize(google_token)
    @google = GoogleService.new(google_token)
  end

  def copy_file(file_id, new_name, folder_name)
    response = @google.drive.list_files(
      q: "mimeType='application/vnd.google-apps.folder' and name='#{folder_name}' and trashed=false"
    )
   
    if response.files.empty?
      folder_metadata = {
        name: folder_name,
        mime_type: 'application/vnd.google-apps.folder'
      }
      folder = @google.drive.create_file(folder_metadata, fields: 'id')
    else
      folder = response.files.first
    end

    file = Google::Apis::DriveV3::File.new
    file.name = new_name
    file.parents = [folder.id]
    copy = @google.drive.copy_file(
      file_id,
      file,
      fields: 'id,name,parents'
    )

    copy
  end

  def replace_text(file_id, search, replace)
    requests = [Google::Apis::DocsV1::Request.new(
      replace_all_text: Google::Apis::DocsV1::ReplaceAllTextRequest.new(
        contains_text: Google::Apis::DocsV1::SubstringMatchCriteria.new(
          text: search, match_case: true
        ), 
        replace_text: replace
      )
    )]

    @google.docs.batch_update_document(
      file_id,
      Google::Apis::DocsV1::BatchUpdateDocumentRequest.new(
        requests: requests
      )
    )
  end

  def generate_pdf(file_id, file_name, folder_name)
    copy = self.copy_file(file_id, file_name, folder_name)
    requests = self.replace_text(copy.id, 'Ricardo', 'George')
    @google.drive.export_file(copy.id, 'application/pdf')
  end
end
