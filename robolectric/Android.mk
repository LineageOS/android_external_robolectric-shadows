##############################################
# Compile Robolectric robolectric
##############################################
LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE := Robolectric_robolectric
LOCAL_MODULE_CLASS := JAVA_LIBRARIES
LOCAL_IS_HOST_MODULE := true

intermediates := $(call local-intermediates-dir)

LOCAL_DONT_DELETE_JAR_META_INF := true

LOCAL_STATIC_JAVA_LIBRARIES := \
  Robolectric_shadows_framework \
  Robolectric_annotations \
  Robolectric_shadowapi \
  Robolectric_resources \
  Robolectric_sandbox \
  Robolectric_junit \
  Robolectric_utils \
  robolectric-host-monitor-1.0.2-alpha1 \
  robolectric-maven-ant-tasks-2.1.3 \
  bouncycastle-unbundled \
  asm-commons-6.0 \
  robolectric-xstream-1.4.8 \
  asm-tree-6.0 \
  junit \
  guava \
  robolectric-ant-1.8.0 \
  asm-6.0 \
  jsr305

LOCAL_JAVA_LIBRARIES := \
  robolectric-host-android_all

LOCAL_SRC_FILES := $(call all-java-files-under, src/main/java)

$(intermediates)/robolectric-version.properties:
	$(hide) echo -n "robolectric.version=3.7-SNAPSHOT" >$@

LOCAL_JAVA_RESOURCE_FILES := $(intermediates)/robolectric-version.properties

include $(BUILD_HOST_JAVA_LIBRARY)

##############################################
# Compile Robolectric robolectric tests
##############################################
include $(CLEAR_VARS)

LOCAL_MODULE := Robolectric_robolectric_tests

LOCAL_SRC_FILES := $(call all-java-files-under, src/test/java)

LOCAL_JAVA_RESOURCE_DIRS := src/test/resources

LOCAL_DONT_DELETE_JAR_META_INF := true

LOCAL_STATIC_JAVA_LIBRARIES := \
  Robolectric_shadows_framework \
  Robolectric_annotations \
  Robolectric_robolectric \
  Robolectric_resources \
  Robolectric_shadowapi \
  Robolectric_sandbox \
  Robolectric_junit \
  Robolectric_utils \
  robolectric-host-monitor-1.0.2-alpha1 \
  robolectric-maven-ant-tasks-2.1.3 \
  robolectric-assertj-core-3.8.0 \
  mockito \
  bouncycastle-unbundled \
  hamcrest \
  robolectric-sqlite4java-0.282 \
  asm-commons-6.0 \
  objenesis \
  robolectric-xstream-1.4.8 \
  asm-tree-6.0 \
  guava \
  junit \
  icu4j \
  robolectric-ant-1.8.0 \
  asm-6.0 \
  jsr305

LOCAL_JAVA_LIBRARIES := \
  robolectric-host-android_all

include $(BUILD_HOST_JAVA_LIBRARY)

##############################################
# Execute Robolectric robolectric tests
##############################################
include $(CLEAR_VARS)

LOCAL_MODULE := Run_robolectric_robolectric_tests

test_source_directory := $(LOCAL_PATH)/src/test/java

test_resources_directory := $(LOCAL_PATH)/src/test/resources

test_runtime_libraries := \
  Robolectric_robolectric_tests \
  robolectric-host-android_all

include external/robolectric-shadows/run_robolectric_module_tests.mk

###########################################
# HACK: specify these *TARGET* jars needed to compile robolectric as though they are prebuilt *HOST* java libraries
###########################################
include $(CLEAR_VARS)


robolectric_target_to_host_jars := \
  robolectric-host-android_all:$(call intermediates-dir-for, JAVA_LIBRARIES, robolectric_android-all-stub,,COMMON)/classes.jar \
  robolectric-host-android-support-v4:$(call java-lib-files, android-support-v4) \
  robolectric-host-android-support-multidex:$(call java-lib-files, android-support-multidex) \
  robolectric-host-org_apache_http_legacy:$(call java-lib-files, org.apache.http.legacy.stubs) \
  robolectric-host-monitor-1.0.2-alpha1:$(call java-lib-files, robolectric-monitor-1.0.2-alpha1)

# Uncomment the line below to compile robolectric against the latest SDK
#robolectric_target_to_host_jars += robolectric-host-android_all:$(call java-lib-files, robolectric_android-all)

# Uncomment the line below to compile robolectric against the O SDK
#robolectric_target_to_host_jars += robolectric-host-android_all:prebuilts/misc/common/robolectric/android-all/android-all-o-preview-4-robolectric-0.jar

$(foreach p,$(robolectric_target_to_host_jars),\
  $(eval include $(CLEAR_VARS)) \
  $(eval LOCAL_MODULE := $(call word-colon,1,$(p))-prebuilt) \
  $(eval LOCAL_MODULE_CLASS := JAVA_LIBRARIES) \
  $(eval LOCAL_IS_HOST_MODULE := true) \
  $(eval LOCAL_PREBUILT_MODULE_FILE := $(call word-colon,2,$(p))) \
  $(eval include $(BUILD_PREBUILT)) \
  $(eval include $(CLEAR_VARS)) \
  $(eval LOCAL_MODULE := $(call word-colon,1,$(p))) \
  $(eval LOCAL_STATIC_JAVA_LIBRARIES := $(call word-colon,1,$(p))-prebuilt) \
  $(eval include $(BUILD_HOST_JAVA_LIBRARY)))
