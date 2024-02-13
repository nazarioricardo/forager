const onPickerApiLoad = function () {
  document.getElementById("pick-file").disabled = false;
};

gapi.load("picker", { callback: onPickerApiLoad });

function pickerCallback(data) {
  if (data[google.picker.Response.ACTION] == google.picker.Action.PICKED) {
    const doc = data[google.picker.Response.DOCUMENTS][0];
    const fileId = doc[google.picker.Document.ID];
    document.getElementById("google-drive-file-id").value = fileId;
    // fetch("/files/pick", {
    //   method: "POST",
    //   headers: {
    //     "Content-Type": "application/json",
    //     "X-CSRF-Token": Rails.csrfToken(),
    //   },
    //   body: JSON.stringify({ fileId: fileId }),
    // });
  }
}

document.addEventListener("DOMContentLoaded", (event) => {
  // Your code here
  var pickFileButton = document.getElementById("pick-file");
  if (pickFileButton) {
    pickFileButton.addEventListener("click", function () {
      const oauthToken = document.body.dataset.googleOauthToken;
      const serviceKey = document.body.dataset.googleServiceKey;
      const picker = new google.picker.PickerBuilder()
        .addView(google.picker.ViewId.DOCUMENTS)
        .setOAuthToken(oauthToken)
        .setDeveloperKey(serviceKey)
        .setCallback(pickerCallback)
        .build();
      picker.setVisible(true);
    });
  }
});
