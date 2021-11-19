import * as React from 'react';
import { View, Text } from 'react-native';
import ChartView from './ChartView.js';

export default class BusinessDetail extends React.Component {
  business = this.props.route.params.business
  render() {
    return <ChartView style={{ flex: 1 }} />;
  }
  // render() {
  //   return (

  //     // <View >
  //     //   <Text> { this.business.name } </Text>
  //     //   <Text> { this.business.location.address}  {this.business.location.city}, {this.business.location.country}</Text>
  //     //   <MapView style={{ flex: 1 }} />
  //     // </View>
  
  //     )
  // }
}


