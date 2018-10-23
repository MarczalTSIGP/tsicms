TSICMS.PermalinkGenerator = class {
   static generateSlug(string) {
      return this.normalizeCharacters(string)
      .replace(/\s/gi, '-')
      .replace(/[^\w\.\-]/gi, '')
      .toLowerCase();
   }

   /**
    * @see https://stackoverflow.com/a/37511463
    */
   static normalizeCharacters(string) {
      return string.normalize('NFD')
      .replace(/[\u0300-\u036f]/g, '');
   }
}
