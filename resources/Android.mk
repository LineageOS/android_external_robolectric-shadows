##############################################
# Compile Robolectric resources
##############################################
LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE := Robolectric_resources

LOCAL_SRC_FILES := $(call all-java-files-under, src/main/java)

LOCAL_STATIC_JAVA_LIBRARIES := \
  Robolectric_annotations \
  Robolectric_utils \
  guava \
  jsr305

include $(BUILD_HOST_JAVA_LIBRARY)

##############################################
# Compile Robolectric resources tests
##############################################
include $(CLEAR_VARS)

LOCAL_MODULE := Robolectric_resources_tests

LOCAL_SRC_FILES := $(call all-java-files-under, src/test/java)

LOCAL_STATIC_JAVA_LIBRARIES := \
  Robolectric_annotations \
  Robolectric_resources \
  Robolectric_utils \
  robolectric-assertj-core-3.8.0 \
  mockito \
  hamcrest \
  objenesis \
  guava \
  junit

include $(BUILD_HOST_JAVA_LIBRARY)

##############################################
# Execute Robolectric resources tests
##############################################
include $(CLEAR_VARS)

LOCAL_MODULE := Run_robolectric_resources_tests

test_source_directory := $(LOCAL_PATH)/src/test/java

test_runtime_libraries := \
  Robolectric_resources_tests

include external/robolectric-shadows/run_robolectric_module_tests.mk
