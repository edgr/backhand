import mapboxgl from 'mapbox-gl';

const initMapboxClubShow = () => {
  const mapElement = document.getElementById('map-show');

  if (mapElement) { // only build a map if there's a div#map to inject into
    const marker = JSON.parse(mapElement.dataset.marker);
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map-show',
      style: 'mapbox://styles/mapbox/streets-v10',
      center: [marker.lng, marker.lat],
      zoom: 8
    });
    if (marker){
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(map);
    }
    map.scrollZoom.disable();
  }
};

export { initMapboxClubShow };
