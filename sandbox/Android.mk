##############################################
# Compile Robolectric sandbox
##############################################
LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE := Robolectric_sandbox

LOCAL_SRC_FILES := $(call all-java-files-under, src/main/java)

LOCAL_STATIC_JAVA_LIBRARIES := \
  Robolectric_annotations \
  Robolectric_shadowapi \
  Robolectric_utils \
  asm-commons-6.0 \
  guava \
  asm-tree-6.0 \
  asm-6.0 \
  jsr305

include $(BUILD_HOST_JAVA_LIBRARY)

##############################################
# Compile Robolectric sandbox tests
##############################################
include $(CLEAR_VARS)

LOCAL_MODULE := Robolectric_sandbox_tests

LOCAL_SRC_FILES := $(call all-java-files-under, src/test/java)

LOCAL_STATIC_JAVA_LIBRARIES := \
  Robolectric_annotations \
  Robolectric_shadowapi \
  Robolectric_sandbox \
  Robolectric_junit \
  Robolectric_utils \
  mockito \
  hamcrest \
  asm-commons-6.0 \
  guava \
  objenesis \
  asm-tree-6.0 \
  junit \
  truth-prebuilt \
  asm-6.0 \
  jsr305

include $(BUILD_HOST_JAVA_LIBRARY)

##############################################
# Execute Robolectric sandbox tests
##############################################
include $(CLEAR_VARS)

LOCAL_MODULE := Run_robolectric_sandbox_tests

test_source_directory := $(LOCAL_PATH)/src/test/java

test_runtime_libraries := \
  Robolectric_sandbox_tests

include external/robolectric-shadows/run_robolectric_module_tests.mk
