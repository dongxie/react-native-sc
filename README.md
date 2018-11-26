# react-native-sc

## How to install

```
npm install react-native-sc
react-native link
```

Since this library is using the advertising identifier, you must remember to add
AdSupport in your IOS project.

Add AdSupport.framework under "Link Binary With Libraries".

## How to use!

```
import { sc } from 'react-native-sc';

class Basic extends Component {
  state = {
     sc: '',
  };

  componentDidMount() {
    sc.getIDFA().then((idfa) => {
      this.setState({ IDFA: idfa, });
    })
    .catch((e) => {
      console.error(e);
    });
  }

  render() {
    return (
      <View style={{ flex: 1 }}>
        <Text>Your IDFA is : {this.state.IDFA}</Text>
      </View>
    );
  }
}
```

## How to run example
