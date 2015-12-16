package com.idea.plugin.applescript.lang.ide.run;

import com.idea.plugin.applescript.AppleScriptFileType;
import com.intellij.execution.actions.ConfigurationContext;
import com.intellij.execution.actions.RunConfigurationProducer;
import com.intellij.openapi.util.Ref;
import com.intellij.openapi.vfs.VirtualFile;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiFile;

public class AppleScriptConfigurationProducer extends RunConfigurationProducer<AppleScriptRunConfiguration> {

  public AppleScriptConfigurationProducer() {
    super(new AppleScriptConfigurationType());
  }

  @Override
  protected boolean setupConfigurationFromContext(AppleScriptRunConfiguration configuration, ConfigurationContext
          context, Ref<PsiElement> sourceElement) {
    PsiElement elem = context.getPsiLocation();
    PsiFile file = elem != null ? elem.getContainingFile() : null;
    if (file == null) return false;
    boolean shouldSetUp = file.getFileType() == AppleScriptFileType.INSTANCE;
    String scriptPath = file.getVirtualFile().getPath();
    configuration.setScriptPath(scriptPath);
    String[] parts = scriptPath.split("/");
    if (parts.length > 0) {
      configuration.setName(parts[parts.length - 1]);
    }
    return shouldSetUp;
  }

  @Override
  public boolean isConfigurationFromContext(AppleScriptRunConfiguration configuration, ConfigurationContext context) {
    PsiElement elem = context.getPsiLocation();
    PsiFile file = elem != null ? elem.getContainingFile() : null;
    if (file == null) return false;
    VirtualFile currentFile = file.getVirtualFile();

    boolean isSameFile = false;
    if (currentFile != null) {
      isSameFile = currentFile.getPath().equals(configuration.getScriptPath());
    }
    return isSameFile;
  }
}
