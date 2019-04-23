##############################################
# Assemble Robolectric_all
##############################################
LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE := Robolectric_all

LOCAL_STATIC_JAVA_LIBRARIES := \
  Robolectric_shadows_androidx_fragment \
  Robolectric_shadows_httpclient \
  Robolectric_shadows_framework \
  Robolectric_shadows_supportv4 \
  Robolectric_shadows_multidex \
  Robolectric_robolectric \
  Robolectric_annotations \
  Robolectric_resources \
  Robolectric_shadowapi \
  Robolectric_sandbox \
  Robolectric_junit \
  Robolectric_utils \
  asm-6.0 \
  junit \
  asm-tree-6.0 \
  guava \
  asm-commons-6.0 \
  bouncycastle-unbundled \
  robolectric-sqlite4java-0.282 \
  hamcrest \
  hamcrest-library \
  robolectric-host-androidx-test-runner \
  robolectric-host-org_apache_http_legacy

LOCAL_JAVA_RESOURCE_DIRS := \
  shadows/framework/src/main/resources \
  src/main/resources

include $(BUILD_HOST_JAVA_LIBRARY)

include $(call first-makefiles-under, $(LOCAL_PATH))

##############################################
# Run all Robolectric tests
##############################################
include $(CLEAR_VARS)

.PHONY: Run_robolectric_test_suite

Run_robolectric_test_suite: \
  Run_robolectric_utils_tests \
  Run_robolectric_sandbox_tests \
  Run_robolectric_processor_tests \
  Run_robolectric_resources_tests \
  Run_robolectric_shadowapi_tests \
  Run_robolectric_robolectric_tests \
  Run_robolectric_shadows_supportv4_tests \
  Run_robolectric_shadows_httpclient_tests \
  Run_robolectric_shadows_androidx_fragment_tests

##############################################
# target prebuilts for Robolectric
##############################################

include $(CLEAR_VARS)
LOCAL_PREBUILT_STATIC_JAVA_LIBRARIES := \
  robolectric-monitor-1.0.2-alpha1:../../../prebuilts/tools/common/m2/repository/com/android/support/test/monitor/1.0.2-alpha1/monitor-1.0.2-alpha1.aar

include $(BUILD_MULTI_PREBUILT)

##############################################
# host prebuilts for Robolectric
##############################################
include $(CLEAR_VARS)
LOCAL_PREBUILT_JAVA_LIBRARIES := \
  robolectric-accessibility-test-framework-2.1:../../../prebuilts/tools/common/m2/repository/com/google/android/apps/common/testing/accessibility/framework/accessibility-test-framework/2.1/accessibility-test-framework-2.1.jar \
  robolectric-ant-1.8.0:../../../prebuilts/tools/common/m2/repository/org/apache/ant/ant/1.8.0/ant-1.8.0.jar \
  robolectric-compile-testing-0.15:../../../prebuilts/tools/common/m2/repository/com/google/testing/compile/compile-testing/0.15/compile-testing-0.15.jar \
  robolectric-diffutils-1.3.0:../../../prebuilts/tools/common/m2/repository/com/googlecode/java-diff-utils/diffutils/1.3.0/diffutils-1.3.0.jar \
  robolectric-httpclient-4.0.3:../../../prebuilts/tools/common/m2/repository/org/apache/httpcomponents/httpclient/4.0.3/httpclient-4.0.3.jar \
  robolectric-httpcore-4.0.1:../../../prebuilts/tools/common/m2/repository/org/apache/httpcomponents/httpcore/4.0.1/httpcore-4.0.1.jar \
  robolectric-javax.annotation-api-1.2:../../../prebuilts/tools/common/m2/repository/javax/annotation/javax.annotation-api/1.2/javax.annotation-api-1.2.jar \
  robolectric-maven-ant-tasks-2.1.3:../../../prebuilts/tools/common/m2/repository/org/apache/maven/maven-ant-tasks/2.1.3/maven-ant-tasks-2.1.3.jar \
  robolectric-sqlite4java-0.282:../../../prebuilts/tools/common/m2/repository/com/almworks/sqlite4java/sqlite4java/0.282/sqlite4java-0.282.jar \
  robolectric-xstream-1.4.8:../../../prebuilts/tools/common/m2/repository/com/thoughtworks/xstream/xstream/1.4.8/xstream-1.4.8.jar
include $(BUILD_HOST_PREBUILT)

##############################################
# HACK: specify these *HOST* jars needed to execute robolectric as though they are prebuilt *TARGET* java libraries
##############################################
include $(CLEAR_VARS)

LOCAL_MODULE := Robolectric_all-target
LOCAL_MODULE_CLASS := JAVA_LIBRARIES
LOCAL_UNINSTALLABLE_MODULE := true
LOCAL_BUILT_MODULE_STEM := javalib.jar
LOCAL_PREBUILT_MODULE_FILE := $(call java-lib-files, Robolectric_all, HOST)

include $(BUILD_PREBUILT)
