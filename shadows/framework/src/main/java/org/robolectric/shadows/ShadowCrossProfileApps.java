/*
 * Copyright (C) 2020 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.robolectric.shadows;

import static android.os.Build.VERSION_CODES.P;

import android.annotation.NonNull;
import android.content.pm.CrossProfileApps;

import org.robolectric.annotation.Implementation;
import org.robolectric.annotation.Implements;
import org.robolectric.annotation.Resetter;

import java.util.HashSet;
import java.util.Set;

/** Robolectric implementation of {@link CrossProfileApps}. */
@Implements(value = CrossProfileApps.class, minSdk = P)
public class ShadowCrossProfileApps {

    private static final Set<String> configurableInteractAcrossProfilePackages = new HashSet<>();

    public void addCrossProfilePackage(String packageName){
        configurableInteractAcrossProfilePackages.add(packageName);
    }

    @Implementation
    protected boolean canConfigureInteractAcrossProfiles(@NonNull String packageName) {
        return configurableInteractAcrossProfilePackages.contains(packageName);
    }

    @Resetter
    public static void reset() {
        configurableInteractAcrossProfilePackages.clear();
    }
}
