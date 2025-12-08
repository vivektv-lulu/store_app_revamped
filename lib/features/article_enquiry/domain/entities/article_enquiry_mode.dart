enum ArticleEnquiryMode {
  ean('E', 'EAN'),
  article('A', 'Article'),
  plu('P', 'PLU');

  final String shortForm;
  final String fullName;

  const ArticleEnquiryMode(this.shortForm, this.fullName);
}

