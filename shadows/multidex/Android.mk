##############################################
# Compile Robolectric shadows multidex
##############################################
LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE := Robolectric_shadows_multidex

LOCAL_STATIC_JAVA_LIBRARIES := \
  Robolectric_annotations \
  Robolectric_shadowapi \
  robolectric-host-android-support-multidex \
  robolectric-javax.annotation-api-1.2

LOCAL_JAVA_LIBRARIES := \
  robolectric-host-android_all

LOCAL_ANNOTATION_PROCESSORS := \
  Robolectric_processor

LOCAL_ANNOTATION_PROCESSOR_CLASSES := org.robolectric.annotation.processing.RobolectricProcessor

LOCAL_JAVACFLAGS := -Aorg.robolectric.annotation.processing.shadowPackage=org.robolectric.shadows.multidex

LOCAL_SRC_FILES := $(call all-java-files-under, src/main/java)

include $(BUILD_HOST_JAVA_LIBRARY)
