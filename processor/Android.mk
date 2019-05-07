##############################################
# Compile Robolectric processor
##############################################
LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE := Robolectric_processor

LOCAL_SRC_FILES := $(call all-java-files-under, src/main/java)

LOCAL_JAVA_RESOURCE_DIRS := src/main/resources

LOCAL_CLASSPATH := $(HOST_JDK_TOOLS_JAR)

LOCAL_STATIC_JAVA_LIBRARIES := \
  Robolectric_annotations \
  guava \
  gson-prebuilt-jar \
  jsr305

include $(BUILD_HOST_JAVA_LIBRARY)

##############################################
# Compile Robolectric processor tests
##############################################
include $(CLEAR_VARS)

LOCAL_MODULE := Robolectric_processor_tests

LOCAL_SRC_FILES := $(call all-java-files-under, src/test/java)

LOCAL_JAVA_RESOURCE_DIRS := src/test/resources

LOCAL_JAVA_RESOURCE_FILES := $(LOCAL_PATH)/src/test/resources

LOCAL_STATIC_JAVA_LIBRARIES := \
  Robolectric_annotations \
  Robolectric_processor \
  Robolectric_shadowapi \
  robolectric-compile-testing-0.15 \
  robolectric-javax.annotation-api-1.2 \
  mockito \
  hamcrest \
  objenesis \
  guava \
  junit \
  truth-prebuilt \
  gson-prebuilt-jar \
  jsr305

# Disable annotation processing while compiling tests to avoid executing RobolectricProcessor.
LOCAL_JAVACFLAGS := -proc:none

include $(BUILD_HOST_JAVA_LIBRARY)

##############################################
# Execute Robolectric processor tests
##############################################
include $(CLEAR_VARS)

LOCAL_MODULE := Run_robolectric_processor_tests

test_source_directory := $(LOCAL_PATH)/src/test/java

test_runtime_libraries := \
  Robolectric_processor_tests

include external/robolectric-shadows/run_robolectric_module_tests.mk
