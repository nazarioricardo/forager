const onPickerApiLoad = function () {
  document.getElementById("pick-file").disabled = false;
};

gapi.load("picker", { callback: onPickerApiLoad });

document.getElementById("pick-file").addEventListener("click", function () {
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

function pickerCallback(data) {
  if (data[google.picker.Response.ACTION] == google.picker.Action.PICKED) {
    const doc = data[google.picker.Response.DOCUMENTS][0];
    const fileId = doc[google.picker.Document.ID];
    fetch("/files/pick", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": Rails.csrfToken(),
      },
      body: JSON.stringify({ fileId: fileId }),
    });
  }
}
