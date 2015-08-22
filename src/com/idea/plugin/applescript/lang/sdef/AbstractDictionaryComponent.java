package com.idea.plugin.applescript.lang.sdef;

import com.idea.plugin.applescript.lang.AppleScriptComponentType;
import com.idea.plugin.applescript.lang.sdef.impl.ApplicationDictionary;
import com.idea.plugin.applescript.psi.AppleScriptExpression;
import com.idea.plugin.applescript.psi.sdef.DictionaryIdentifier;
import com.idea.plugin.applescript.psi.sdef.impl.DictionaryComponentBase;
import com.idea.plugin.applescript.psi.sdef.impl.DictionaryIdentifierImpl;
import com.intellij.openapi.util.text.StringUtil;
import com.intellij.psi.PsiElement;
import com.intellij.psi.xml.XmlAttribute;
import com.intellij.psi.xml.XmlAttributeValue;
import com.intellij.psi.xml.XmlTag;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.Arrays;
import java.util.List;

/**
 * Created by Andrey on 09.07.2015.
 */
public abstract class AbstractDictionaryComponent<P extends DictionaryComponent>
        extends DictionaryComponentBase<P, XmlTag> implements DictionaryComponent {

  @NotNull private final String code;
  @NotNull private final String name;
  @Nullable private String description;

  protected AbstractDictionaryComponent(@NotNull P parent, @NotNull String name, @NotNull String code,
                                        @NotNull XmlTag myXmlTag, @Nullable String description) {
    super(myXmlTag, parent);
    this.code = code;
    this.name = name;
    this.description = description;
  }

  protected AbstractDictionaryComponent(@NotNull P parent, @NotNull String name,
                                        @NotNull String code, @NotNull XmlTag myXmlTag) {
    super(myXmlTag, parent);
    this.code = code;
    this.name = name;
  }

  @Override
  public boolean isGlobal() {
    return true;
  }

  @Override
  public boolean isScriptProperty() {
    return false;
  }

  @Override
  public boolean isHandler() {
    return false;
  }

  @Nullable
  @Override
  public PsiElement getOriginalDeclaration() {
    return this;
  }

  @Override
  public boolean isObjectProperty() {
    return false;
  }

  @Override
  public boolean isComposite() {
    return false;
  }

  @Override
  public boolean isResolveTarget() {
    return true;
  }

  @Override
  public boolean isVariable() {
    return false;
  }

  @Nullable
  @Override
  public AppleScriptExpression findAssignedValue() {
    return null;
  }

  @NotNull
  @Override
  public String getName() {
    return name;
  }

  @NotNull
  @Override
  public List<String> getNameIdentifiers() {
    return Arrays.asList(name.split(" "));
  }

  @NotNull
  @Override
  public String getQualifiedName() {
    return getDictionaryParentComponent().getQualifiedName() + "/" + getShortQname();
  }

  @NotNull
  private String getShortQname() {
    return getType().substring(11) + ":" + getCode();
  }

  @NotNull
  @Override
  public String getQualifiedPath() {
    return getDictionaryParentComponent().getQualifiedPath() + "/" + getShortQname();
  }

  @NotNull
  @Override
  public String getType() {
    //prefixed with "dictionary " to distinguish from native AppleScript types..
    AppleScriptComponentType componentType = AppleScriptComponentType.typeOf(this);
    return componentType != null ? componentType.toString().toLowerCase() : "dictionary reference";
  }

  @Override
  public void setDescription(@Nullable String description) {
    this.description = description;
  }

  @NotNull
  @Override
  public ApplicationDictionary getDictionary() {
    return getSuite().getDictionary();
  }

  @Nullable
  @Override
  public String getCocoaClassName() {
    return null;
  }

  @NotNull
  @Override
  public String getDocumentation() {
    StringBuilder sb = new StringBuilder();
    String type = StringUtil.capitalizeWords(getType(),true);
    String name = getName();
    sb.append("<b>").append(getDictionary().getName()).append("</b> ").
            append(StringUtil.capitalize(getDictionary().getType())).append("<br>");
    sb.append("<p>").append(type.substring(10)).append(" <b>").append(name).
            append("</b>").append(" : ").append(StringUtil.notNullize(getDescription())).append("</p>");
    return sb.toString();
  }

  @NotNull
  @Override
  public String getCode() {
    return code;
  }

  @Nullable
  public String getDescription() {
    return description;
  }

  @NotNull
  @Override
  public abstract Suite getSuite();

  @Nullable
  @Override
  public String getLocationString() {
    return getQualifiedPath();
  }

  @NotNull
  @Override
  public DictionaryIdentifier getIdentifier() {
    DictionaryIdentifier myIdentifier = null;
    XmlAttribute nameAttr = myXmlElement.getAttribute("name");
    if (nameAttr != null) {
      XmlAttributeValue attrValue = nameAttr.getValueElement();
      if (attrValue != null) {
        myIdentifier = new DictionaryIdentifierImpl(this, getName(), attrValue);
      }
    }
    else {
      for (XmlAttribute anyAttr: myXmlElement.getAttributes()) {
        myIdentifier = new DictionaryIdentifierImpl(this, getName(), anyAttr);
      }
    }
    return myIdentifier!=null ? myIdentifier :
            new DictionaryIdentifierImpl(this, getName(), myXmlElement.getAttributes()[0]);
  }

  @Nullable
  @Override
  public PsiElement getNameIdentifier() {
    return getIdentifier();
  }
}
