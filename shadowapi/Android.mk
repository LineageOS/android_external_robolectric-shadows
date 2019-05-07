##############################################
# Compile Robolectric shadowapi
##############################################
LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE := Robolectric_shadowapi

LOCAL_STATIC_JAVA_LIBRARIES := jsr305

LOCAL_SRC_FILES := $(call all-java-files-under, src/main/java)

include $(BUILD_HOST_JAVA_LIBRARY)

##############################################
# Compile Robolectric shadowapi tests
##############################################
include $(CLEAR_VARS)

LOCAL_MODULE := Robolectric_shadowapi_tests

LOCAL_SRC_FILES := $(call all-java-files-under, src/test/java)

LOCAL_STATIC_JAVA_LIBRARIES := \
  Robolectric_shadowapi \
  robolectric-assertj-core-3.8.0 \
  hamcrest \
  junit

include $(BUILD_HOST_JAVA_LIBRARY)

##############################################
# Execute Robolectric shadowapi tests
##############################################
include $(CLEAR_VARS)

LOCAL_MODULE := Run_robolectric_shadowapi_tests

test_source_directory := $(LOCAL_PATH)/src/test/java

test_runtime_libraries := \
  Robolectric_shadowapi_tests

include external/robolectric-shadows/run_robolectric_module_tests.mk
