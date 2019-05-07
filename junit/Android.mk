###########################################
# Compile Robolectric junit
###########################################
LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE := Robolectric_junit

LOCAL_STATIC_JAVA_LIBRARIES := \
  Robolectric_annotations \
  Robolectric_shadowapi \
  Robolectric_sandbox \
  Robolectric_utils \
  asm-commons-6.0 \
  asm-tree-6.0 \
  hamcrest \
  junit \
  asm-6.0 \
  guava \
  jsr305

LOCAL_SRC_FILES := $(call all-java-files-under, src/main/java)

include $(BUILD_HOST_JAVA_LIBRARY)
