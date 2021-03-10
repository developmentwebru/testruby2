import '@uppy/core/dist/style.css'
import '@uppy/dashboard/dist/style.css'

import Uppy from '@uppy/core'
import Dashboard from '@uppy/dashboard'
import russianLocale from '@uppy/locales/lib/ru_RU'
import AwsS3 from '@uppy/aws-s3'
import datePlusRandomNumber from 'util/datePlusRandomNumber'

function fileUploader() {
  const dashboardTarget = document.querySelector('.file-upload-target')
  const hiddenFieldsModelName = dashboardTarget.getAttribute('data-model-name')
  const hiddenFieldsNestedAttributesName = dashboardTarget.getAttribute('data-nested-attributes-name')
  const maxFiles = dashboardTarget.getAttribute('data-max-files')

  const uppy = new Uppy({
    //debug: true,
    autoProceed: false,
    locale: russianLocale,
    restrictions: {
      maxFileSize: 10485760, // 10Mb
      maxNumberOfFiles: maxFiles,
      allowedFileTypes: ['image/jpeg', 'image/png']
    }
  })
  .use(Dashboard, {
    target: dashboardTarget,
    inline: true,
    height: 300,
    proudlyDisplayPoweredByUppy: false
  })
  .use(AwsS3, {
    limit: 2, // Parallel uploads limit
    companionUrl: '/'
  })

  uppy.on('upload-success', (file, _response) => {
    // construct uploaded file data in the format that Shrine expects
    const uploadedFileData = JSON.stringify({
      id: file.meta['key'].match(/^cache\/(.+)/)[1], // object key without prefix
      storage: 'cache',
      metadata: {
        size: file.size,
        filename: file.name,
        mime_type: file.type,
      }
    })

    // set hidden field value to the uploaded file data so that it's submitted
    // with the form as the attachment
    const hiddenField = document.createElement('input')
    hiddenField.type = 'hidden'
    hiddenField.name = `${hiddenFieldsModelName}[${hiddenFieldsNestedAttributesName}_attributes][${datePlusRandomNumber()}][image]`
    hiddenField.value = uploadedFileData
    document.querySelector('.file-upload-hidden-fields').appendChild(hiddenField)
  })
}

export default fileUploader
