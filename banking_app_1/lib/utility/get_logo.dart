String getLogoForCards(String service) {
    switch (service) {
      case 'Netflix':
        return 'assets/transactionLogos/netflix.png';
      case 'Spotify':
        return 'assets/transactionLogos/spotify.png';
      case 'Amazon':
        return 'assets/transactionLogos/amazon.png';
      case 'Disney+':
        return 'assets/transactionLogos/disney.png';
      case 'Apple Store':
        return 'assets/transactionLogos/appleStore.png';
      case 'Red Cross':
        return 'assets/transactionLogos/croceRossa.png';
      case 'Ebay':
        return 'assets/transactionLogos/ebay.png';
      case 'Google Workspace':
        return 'assets/transactionLogos/google.png';
      case 'Airbnb':
        return 'assets/transactionLogos/airbnb.png';       
      default:
        return 'assets/transactionLogos/money.png';
    }
  }