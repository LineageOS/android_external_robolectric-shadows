##############################################
# Compile Robolectric processor
##############################################
LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE := Robolectric_processor
LOCAL_MODULE_CLASS := JAVA_LIBRARIES
LOCAL_IS_HOST_MODULE := true

sdks_txt_file := $(call local-intermediates-dir)/sdks.txt

LOCAL_SRC_FILES := $(call all-java-files-under, src/main/java)

LOCAL_JAVA_RESOURCE_DIRS := src/main/resources

LOCAL_CLASSPATH := $(HOST_JDK_TOOLS_JAR)

LOCAL_STATIC_JAVA_LIBRARIES := \
  Robolectric_annotations \
  Robolectric_shadowapi \
  asm-commons-6.0 \
  guava \
  asm-tree-6.0 \
  gson-prebuilt-jar \
  asm-6.0 \
  jsr305

LOCAL_JAVA_RESOURCE_FILES := $(sdks_txt_file)

$(sdks_txt_file): private_top := $(TOP)

$(sdks_txt_file):
	$(hide) rm -f $@
	$(hide) echo "$(private_top)/prebuilts/misc/common/robolectric/android-all/android-all-4.1.2_r1-robolectric-r1.jar" >>$@
	$(hide) echo "$(private_top)/prebuilts/misc/common/robolectric/android-all/android-all-4.2.2_r1.2-robolectric-r1.jar" >>$@
	$(hide) echo "$(private_top)/prebuilts/misc/common/robolectric/android-all/android-all-4.3_r2-robolectric-r1.jar" >>$@
	$(hide) echo "$(private_top)/prebuilts/misc/common/robolectric/android-all/android-all-4.4_r1-robolectric-r2.jar" >>$@
	$(hide) echo "$(private_top)/prebuilts/misc/common/robolectric/android-all/android-all-5.0.2_r3-robolectric-r0.jar" >>$@
	$(hide) echo "$(private_top)/prebuilts/misc/common/robolectric/android-all/android-all-5.1.1_r9-robolectric-r2.jar" >>$@
	$(hide) echo "$(private_top)/prebuilts/misc/common/robolectric/android-all/android-all-6.0.1_r3-robolectric-r1.jar" >>$@
	$(hide) echo "$(private_top)/prebuilts/misc/common/robolectric/android-all/android-all-7.0.0_r1-robolectric-r1.jar" >>$@
	$(hide) echo "$(private_top)/prebuilts/misc/common/robolectric/android-all/android-all-7.1.0_r7-robolectric-r1.jar" >>$@
	$(hide) echo "$(private_top)/prebuilts/misc/common/robolectric/android-all/android-all-8.0.0_r4-robolectric-r1.jar" >>$@
	$(hide) echo "$(private_top)/prebuilts/misc/common/robolectric/android-all/android-all-8.1.0-robolectric-4611349.jar" >>$@
	$(hide) echo "$(private_top)/prebuilts/misc/common/robolectric/android-all/android-all-9-robolectric-4913185-2.jar" >>$@

ifdef TARGET_OPENJDK9
LOCAL_JAVACFLAGS := \
   --add-exports=jdk.compiler/com.sun.tools.javac.code=ALL-UNNAMED \
   --add-exports=jdk.compiler/com.sun.tools.javac.util=ALL-UNNAMED
endif

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
  Robolectric_annotations \
  Robolectric_processor \
  Robolectric_shadowapi \
  robolectric-javax.annotation-api-1.2 \
  robolectric-compile-testing-0.15 \
  mockito \
  hamcrest \
  guava \
  objenesis \
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
