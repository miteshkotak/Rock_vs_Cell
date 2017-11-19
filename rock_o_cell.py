#####  SHDB17 #############

########## ROCk vs Cell #############

import cv2
import glob, os
import numpy as np
from matplotlib import pyplot as plt
import argparse
import sys

#raw_image = cv2.imread(sys.argv[1])
#raw_image = cv2.imread(args["image"])
raw_image = cv2.imread('/home/mitesh/Dropbox/Share/hello.png')
cv2.imshow('Original Image', raw_image)

# bilateral filetring 
bilateral_filtered_image = cv2.bilateralFilter(raw_image, 2, 175, 175)
cv2.imshow('Bilateral', bilateral_filtered_image)

#canny edge detection
img =cv2.blur(bilateral_filtered_image,(10,10))
for e in range(5):
    img = cv2.erode(img,(5,5))
retval, img = cv2.threshold(img,175,255,cv2.THRESH_BINARY)
img2=img
img2=cv2.Canny(img2,100,200,3)
img2=cv2.dilate(img2,(2,2))
cv2.imshow('edge detected',img2)


#edge_detected_image = cv2.Canny(bilateral_filtered_image, 75, 150, 30)
#cv2.imshow('Edge', edge_detected_image)

# Contor mapping
ret,thresh = cv2.threshold(img2,100,255,1)

_, contours, hierarchy = cv2.findContours(thresh, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)

for cnt in contours:
    approx = cv2.approxPolyDP(cnt,0.01*cv2.arcLength(cnt,True),True)
    print len(approx)
    if len(approx) < 9:
        print "ROck"
        cv2.drawContours(raw_image,[cnt],0,(255,0,0),-1)
    #elif len(approx)==3:
      #  print "triangle"
     #   cv2.drawContours(raw_image,[cnt],0,(0,255,0),-1)
    #elif len(approx)==4:
    #    print "square"
   #     cv2.drawContours(raw_image,[cnt],0,(0,0,0),-1)
  #  elif len(approx) == 9:
 #       print "half-circle"
#        cv2.drawContours(raw_image,[cnt],0,(10,10,255),-1)
    elif len(approx) > 15:
        print "cell"
        cv2.drawContours(raw_image,[cnt],0,(0,0,255),-1)
#(blue,green,red = blue)
cv2.imshow('img',raw_image)
cv2.waitKey(0)
