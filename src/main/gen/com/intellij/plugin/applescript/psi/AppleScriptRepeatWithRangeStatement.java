// This is a generated file. Not intended for manual editing.
package com.intellij.plugin.applescript.psi;

import java.util.List;
import org.jetbrains.annotations.*;
import com.intellij.psi.PsiElement;

public interface AppleScriptRepeatWithRangeStatement extends AppleScriptPsiElement {

  @Nullable
  AppleScriptBlockBody getBlockBody();

  @NotNull
  AppleScriptDirectParameterDeclaration getDirectParameterDeclaration();

  @NotNull
  List<AppleScriptExpression> getExpressionList();

}
