package com.idea.plugin.applescript.psi.sdef.impl;

import com.idea.plugin.applescript.lang.sdef.DictionaryComponent;
import com.idea.plugin.applescript.psi.sdef.DictionaryIdentifier;
import com.intellij.psi.PsiElement;
import com.intellij.psi.xml.XmlElement;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Created by Andrey on 19.08.2015.
 * simple identifier, for XmlToken's inside components like: <'command name="my command name" ...>...<'/command>
 * here DictionaryIdentifierImpl is "my command name". But getVarIdentifier will return same psi but with "my" text
 * todo need to check if it matters for some situations as getText() for this class could return several words and text
 * search could be broken (we can use getVarIdentifier() then)
 */
public class DictionaryIdentifierImpl extends DictionaryComponentBase<DictionaryComponent, XmlElement>
        implements DictionaryIdentifier {

  @NotNull private final String varIdentifierText;
  @NotNull private final List<String> varIdentifierTextList;

  public DictionaryIdentifierImpl(@NotNull DictionaryComponent myParent, @NotNull String varIdentifierText,
                                  @NotNull XmlElement myXmlAttributeValue) {
    super(myXmlAttributeValue, myParent);
//    assert varIdentifierText.split(" ").length == 1; //ensure that only atomic text values are created..(or does it
// matter??)
    this.varIdentifierText = varIdentifierText;
    varIdentifierTextList = new ArrayList<String>(Arrays.asList(varIdentifierText.split(" ")));
  }

  @NotNull
  @Override
  public PsiElement getVarIdentifier() {
    return new DictionaryIdentifierImpl(myParent, varIdentifierTextList.get(0), myXmlElement);
  }

  @Override
  public int getTextLength() {
    return varIdentifierText.length();
  }

  @Nullable
  @Override
  public PsiElement findElementAt(int offset) {
    return this;
  }

  @Nullable
  @Override
  public String getText() {
    return varIdentifierText;
  }

  @Override
  public String getName() {
    return getText();
  }

  @NotNull
  @Override
  public PsiElement getParent() {
    return myParent;
  }

}
