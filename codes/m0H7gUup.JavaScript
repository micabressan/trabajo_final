/**
 * Copyright 2016 Google Inc. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for t`he specific language governing permissions and
 * limitations under the License.
 */
'use strict';

// [START import]
const functions = require('firebase-functions');
const gcs = require('@google-cloud/storage')();
const spawn = require('child-process-promise').spawn;
const path = require('path');
const os = require('os');
const fs = require('fs');
// [END import]

// [START ImageReduce]
/**
 * When an image is uploaded in the Storage bucket We resize image automatically using
 * ImageMagick.
 */
// [START ImageReduceTrigger]
exports.ImageReduce = functions.storage.object().onChange(event => {
// [END ImageReduceTrigger]
  // [START eventAttributes]
  const object = event.data; // The Storage object.

  const fileBucket = object.bucket; // The Storage bucket that contains the file.
  const filePath = object.name; // File path in the bucket.
  const contentType = object.contentType; // File content type.
  const resourceState = object.resourceState; // The resourceState is 'exists' or 'not_exists' (for file/folder deletions).
  const metageneration = object.metageneration; // Number of times metadata has been generated. New objects have a value of 1.
  // [END eventAttributes]

  // [START stopConditions]
  // Exit if this is triggered on a folder that is not images/.
  if (!filePath.startsWith('images/')) {
    console.log('This is not an folder images.');
    return;
  }

  // Exit if this is triggered on a file that is not an image.
  if (!contentType.startsWith('image/')) {
    console.log('This is not an image.');
    return;
  }

  // Get the file name.
  const fileName = path.basename(filePath);
  // Exit if the image is already resize.
  if (fileName.endsWith('_s')) {
    console.log('Already resize s.');
    return;
  }
  if (fileName.endsWith('_m')) {
    console.log('Already resize m.');
    return;
  }
  if (fileName.endsWith('_l')) {
    console.log('Already resize s.');
    return;
  }

  // Exit if this is a move or deletion event.
  if (resourceState === 'not_exists') {
    console.log('This is a deletion event.');
    return;
  }

  // Exit if file exists but is not new and is only being triggered
  // because of a metadata change.
  if (resourceState === 'exists' && metageneration > 1) {
    console.log('This is a metadata change event.');
    return;
  }
  // [END stopConditions]

  // [START resizeGeneration]
  // Download file from bucket.
  const bucket = gcs.bucket(fileBucket);
  const sizes = ['s', 'm', 'l'];
  const pixel = ['300x300', '640x640', '1080x1080'];
  const paths = ['','',''];
  const tempFilePath = path.join(os.tmpdir(), fileName);
  const metadata = { contentType: contentType };
  return new Promise((resolve) => {
    bucket.file(filePath).download({
      destination: tempFilePath
    }).then(() => {
      return sizes.map((size, index) => {
        return new Promise((resolve) => {
          paths[index] = path.join(os.tmpdir(), size);
          // Resize image using ImageMagick.
          spawn('convert', [tempFilePath, '-resize', `${pixel[index]}`, paths[index]])
          .then(() => {
            // We add a time prefix to file. That's where we'll upload the image.
            const reduceFileName = `${Date.now()}_${size}`;
            const reduceFilePath = path.join(path.dirname(filePath), reduceFileName);
            // Uploading the image.
            return bucket.upload(paths[index], { destination: reduceFilePath, metadata: metadata });
          }).then(() => {
            resolve();
          });
        });
      });
    }).then((reduceAll) => {
      Promise.all(reduceAll).then(() => {
        // Once the resize image has been uploaded delete the local file to free up disk space.
        fs.unlinkSync(tempFilePath)
        paths.map((path) => fs.unlinkSync(path));
        resolve();
      });
    });
  });
});
// [END ImageReduce]