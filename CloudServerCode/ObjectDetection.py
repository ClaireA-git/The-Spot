import os
import pathlib
import shutil
from time import sleep

import matplotlib
import matplotlib.pyplot as plt

import io
import scipy.misc
import numpy as np
from six import BytesIO
from PIL import Image, ImageDraw, ImageFont
from six.moves.urllib.request import urlopen

import tensorflow as tf
import tensorflow_hub as hub

from updateDatabase import update_database

# tf.get_logger().setLevel('ERROR')

def load_image_into_numpy_array(path):
  """Load an image from file into a numpy array.

  Puts image into numpy array to feed into tensorflow graph.
  Note that by convention we put it into a numpy array with shape
  (height, width, channels), where channels=3 for RGB.

  Args:
    path: the file path to the image

  Returns:
    uint8 numpy array with shape (img_height, img_width, 3)
  """
  image = None
  if(path.startswith('http')):
    response = urlopen(path)
    image_data = response.read()
    image_data = BytesIO(image_data)
    image = Image.open(image_data)
  else:
    image_data = tf.io.gfile.GFile(path, 'rb').read()
    image = Image.open(BytesIO(image_data))

  (im_width, im_height) = image.size
  return np.array(image.getdata()).reshape(
      (1, im_height, im_width, 3)).astype(np.uint8)


ALL_MODELS = {
'CenterNet HourGlass104 512x512' : 'https://tfhub.dev/tensorflow/centernet/hourglass_512x512/1',
'CenterNet HourGlass104 Keypoints 512x512' : 'https://tfhub.dev/tensorflow/centernet/hourglass_512x512_kpts/1',
}

from object_detection.utils import label_map_util
from object_detection.utils import visualization_utils as viz_utils
from object_detection.utils import ops as utils_ops

PATH_TO_LABELS = '../models/research/object_detection/data/mscoco_label_map.pbtxt'
category_index = label_map_util.create_category_index_from_labelmap(PATH_TO_LABELS, use_display_name=True)

model_display_name = 'CenterNet HourGlass104 Keypoints 512x512' # @param ['CenterNet HourGlass104 512x512','CenterNet HourGlass104 Keypoints 512x512','CenterNet HourGlass104 1024x1024','CenterNet HourGlass104 Keypoints 1024x1024','CenterNet Resnet50 V1 FPN 512x512','CenterNet Resnet50 V1 FPN Keypoints 512x512','CenterNet Resnet101 V1 FPN 512x512','CenterNet Resnet50 V2 512x512','CenterNet Resnet50 V2 Keypoints 512x512','EfficientDet D0 512x512','EfficientDet D1 640x640','EfficientDet D2 768x768','EfficientDet D3 896x896','EfficientDet D4 1024x1024','EfficientDet D5 1280x1280','EfficientDet D6 1280x1280','EfficientDet D7 1536x1536','SSD MobileNet v2 320x320','SSD MobileNet V1 FPN 640x640','SSD MobileNet V2 FPNLite 320x320','SSD MobileNet V2 FPNLite 640x640','SSD ResNet50 V1 FPN 640x640 (RetinaNet50)','SSD ResNet50 V1 FPN 1024x1024 (RetinaNet50)','SSD ResNet101 V1 FPN 640x640 (RetinaNet101)','SSD ResNet101 V1 FPN 1024x1024 (RetinaNet101)','SSD ResNet152 V1 FPN 640x640 (RetinaNet152)','SSD ResNet152 V1 FPN 1024x1024 (RetinaNet152)','Faster R-CNN ResNet50 V1 640x640','Faster R-CNN ResNet50 V1 1024x1024','Faster R-CNN ResNet50 V1 800x1333','Faster R-CNN ResNet101 V1 640x640','Faster R-CNN ResNet101 V1 1024x1024','Faster R-CNN ResNet101 V1 800x1333','Faster R-CNN ResNet152 V1 640x640','Faster R-CNN ResNet152 V1 1024x1024','Faster R-CNN ResNet152 V1 800x1333','Faster R-CNN Inception ResNet V2 640x640','Faster R-CNN Inception ResNet V2 1024x1024','Mask R-CNN Inception ResNet V2 1024x1024']
model_handle = ALL_MODELS[model_display_name]

print('Selected model:'+ model_display_name)
print('Model Handle at TensorFlow Hub: {}'.format(model_handle))

print('loading model...')
hub_model = hub.load(model_handle)
print('model loaded!')

running = True

while(running == True):
    if (len(os.listdir('/home/thespotods/Receive/')) <= 0):       
        sleep(1)
        

    else:
        sleep(2)
        # hard coded parking spot tensor values
        spots = [0.299613, 0.538616, False],[0.332259, 0.529462, False],[0.368342, 0.529462, False],[0.400129, 0.527746, False],[0.429768, 0.523169, False],[0.458978, 0.524886, False],[0.488187, 0.520309, False],[0.516967, 0.517449, False],[0.547036, 0.520881, False],[0.577105, 0.512300, False],[0.608462, 0.510011, False],[0.636383, 0.508295, False],[0.425473, 0.568936, False],[0.459407, 0.567792, False],[0.490335, 0.564359, False],[0.525129, 0.561499, False],[0.556916, 0.563787, False],[0.583548, 0.562643, False],[0.643686, 0.546053, False],[0.669029, 0.542620, False],[0.700387, 0.538043, False],[0.730455, 0.537471, False],[0.763101, 0.538616, False],[0.784579, 0.535755, False],[0.821950, 0.536327, False],[0.431486, 0.604977, False],[0.469716, 0.602117, False],[0.507947, 0.597540, False],[0.535868, 0.596396, False],[0.569802, 0.595252, False],[0.607174, 0.587243, False],[0.640679, 0.586098, False],[0.672895, 0.578089, False],[0.705112, 0.577517, False],[0.737758, 0.576373, False],[0.766108, 0.566076, False],[0.799184, 0.559783, False],[0.828393, 0.560355, False],[0.863187, 0.558638, False],[0.260524, 0.712815, False],[0.319373, 0.713387, False],[0.380369, 0.708238, False],[0.433634, 0.693364, False],[0.493771, 0.688215, False],[0.535868, 0.682494, False],[0.586985, 0.680206, False],[0.638101, 0.671053, False],[0.684064, 0.671625, False],[0.737328, 0.665332, False],[0.788015, 0.658467, False],[0.825387, 0.655034, False],[0.871778, 0.646453, False],[0.907002, 0.643593, False],[0.956400, 0.627002, False],[0.244201, 0.542048, False],[0.243771, 0.553490, False],[0.233033, 0.569508, False],[0.231314, 0.588387, False],[0.221005, 0.613558, False],[0.205971, 0.628432, False],[0.187500, 0.655320, False],[0.184064, 0.687929, False]
        selected_image = os.listdir('/home/thespotods/Receive/')[0]

        try:
        	image_path = '/home/thespotods/Receive/'+selected_image
        	image_np = load_image_into_numpy_array(image_path)

	        # running inference
	        results = hub_model(image_np)

	        # different object detection models have additional results
	        # all of them are explained in the documentation
	        result = {key:value.numpy() for key,value in results.items()}

	        label_id_offset = 0
	        image_np_with_detections = image_np.copy()

	        # Use keypoints if available in detections
	        keypoints, keypoint_scores = None, None
	        if 'detection_keypoints' in result:
	          keypoints = result['detection_keypoints'][0]
	          keypoint_scores = result['detection_keypoint_scores'][0]

	        for i in range(len(result['detection_scores'][0])):
	            if result['detection_scores'][0][i-1] > .30:
	                lastindex = i-1
	
	        # Check which spots are taken
	        for i in range(lastindex+1):
	            # Iterate only through the objects labeled as a Truck (8) or a Car(3)
	            if (result['detection_classes'][0][i] == 8) or (result['detection_classes'][0][i] == 3):
	                # Throw out any objects detected that take up more then 40% of the X and Y plane
	                if((result['detection_boxes'][0][i][3]-result['detection_boxes'][0][i][1]) < .4) and ((result['detection_boxes'][0][i][2]-result['detection_boxes'][0][i][0]) < .4):
	                    # Now that we've ensured the object is an actual car in the parking lot, check which spot the car is in'
	                    for j in range(len(spots)):
	                        # Check if vehicle is between the X values of the spot
	                        if (result['detection_boxes'][0][i][3] > spots[j][0] and result['detection_boxes'][0][i][1] < spots[j][0]):
	                            # Check if vehicle is between the Y values of the spot
	                            if (result['detection_boxes'][0][i][2] > spots[j][1] and result['detection_boxes'][0][i][0] < spots[j][1]):
	                                # Print the data of the object detected in a spot
	                                spots[j][2] = True

	        update_database(spots)

                # draw outlines on the image for visual representation
	        viz_utils.visualize_boxes_and_labels_on_image_array(
	              image_np_with_detections[0],
	              result['detection_boxes'][0],
	              (result['detection_classes'][0] + label_id_offset).astype(int),
	              result['detection_scores'][0],
	              category_index,
	              use_normalized_coordinates=True,
	              max_boxes_to_draw=200,
	              min_score_thresh=.30,
	              agnostic_mode=False,
	              keypoints=keypoints,
	              keypoint_scores=keypoint_scores,
	              keypoint_edges=COCO17_HUMAN_POSE_KEYPOINTS)

	        plt.figure(figsize=(46,35))
	        plt.imshow(image_np_with_detections[0])
	        plt.savefig("ODs_"+selected_image)
	        plt.close()

                # move images to their propper folders
	        shutil.move(image_path, '/home/thespotods/Archive/'+selected_image)
	        shutil.move("/home/thespotods/Capstone/ODs_"+selected_image, '/home/thespotods/OD_Archive/ODs_'+selected_image)

        # if the first image sent is un-readable delete the image
        except:
        	os.remove(image_path)
