import * as React from 'react';
import { View, Text } from 'react-native';

export default class BusinessDetail extends React.Component {
  business = this.props.route.params.business

  render() {
    return (

      <View >
        <Text> { this.business.name } </Text>
        <Text> { this.business.location.address}  {this.business.location.city}, {this.business.location.country}</Text>
      </View>
  
      )
  }
}


