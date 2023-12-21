import React from 'react';
import './HomePage.css';
// Import additional components as they are created
// import HeroSection from '../components/HeroSection';
// import FeaturesOverview from '../components/FeaturesOverview';
// import SpotifyIntegration from '../components/SpotifyIntegration';
// import TestimonialsCarousel from '../components/TestimonialsCarousel';
// import LatestContent from '../components/LatestContent';
// import RegistrationCTA from '../components/RegistrationCTA';
import './HomePage.css';
import HeroSection from '../components/HeroSection';

const HomePage = () => {
    return (
        <div className="home-page">
            {/* Hero Section */}
            {/* <HeroSection /> */}

            <HeroSection />
            {/* Features Overview Section */}
            {/* <FeaturesOverview /> */}

            {/* Spotify Integration Highlight */}
            {/* <SpotifyIntegration /> */}

            {/* User Testimonials Carousel */}
            {/* <TestimonialsCarousel /> */}

            {/* Latest Content Display */}
            {/* <LatestContent /> */}

            {/* Registration CTA */}
            {/* <RegistrationCTA /> */}

            {/* Enhanced Footer */}
            <Footer />
            <Footer />
        </div>
    );
}

export default HomePage;
