/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

import React from 'react';
import type {PropsWithChildren} from 'react';
import {
  SafeAreaView,
  ScrollView,
  StatusBar,
  StyleSheet,
  Text,
  useColorScheme,
  View,
  NativeModules,
} from 'react-native';

import {
  Colors,
  DebugInstructions,
  Header,
  LearnMoreLinks,
  ReloadInstructions,
} from 'react-native/Libraries/NewAppScreen';

type SectionProps = PropsWithChildren<{
  title: string;
}>;

function Section({children, title}: SectionProps): JSX.Element {
  const isDarkMode = useColorScheme() === 'dark';
  return (
    <View style={styles.sectionContainer}>
      <Text
        style={[
          styles.sectionTitle,
          {
            color: isDarkMode ? Colors.white : Colors.black,
          },
        ]}>
        {title}
      </Text>
      <Text
        style={[
          styles.sectionDescription,
          {
            color: isDarkMode ? Colors.light : Colors.dark,
          },
        ]}>
        {children}
      </Text>
    </View>
  );
}

function App(): JSX.Element {
  const isDarkMode = useColorScheme() === 'dark';

  const Howxm = NativeModules.HowxmRN;

  Howxm.initializeSDK('5ed93d69-7f44-44a7-8769-f8ad131a2010', () => {
    console.log('initializeSDK completion');

    Howxm.checkInitialized((initialized: any) => {
      console.log('Initialized:', initialized);
    });

    Howxm.onBeforeOpen(
      (campaignId: string, uid: string, extraAttributes: any) => {
        console.log('onBeforeOpen:', campaignId, uid, extraAttributes);
      },
    );

    Howxm.onPageComplete(
      (campaignId: string, uid: string, fieldEntries: Array<any>) => {
        console.log('onPageComplete:', campaignId, uid, fieldEntries);
      },
    );

    Howxm.checkOpen(
      '6329d0091a5c789fb97eab345585fded',
      'uid_001',
      () => {
        console.log('checkOpen success');
      },
      () => {
        console.error('checkOpen failed');
      },
    );

    Howxm.identify(
      {
        uid: 'uid_001',
        name: 'zhangsan',
        email: 'zhangsan@howxm.com',
        mobile: '13000000000',
        extraAttributes: {age: 18},
      },
      () => {
        console.log('identify success');
      },
      () => {
        console.error('identify failed');
      },
    );

    // Howxm.open(
    //   '6329d0091a5c789fb97eab345585fded',
    //   {uid: 'uid_001', name: 'zhangsan', extraAttributes: {age: 18}},
    //   {},
    // );
    Howxm.event(
      'payment_click',
      {price: 100, channel: 'React Native'},
      () => {
        console.info('event success');
      },
      (error: any) => {
        console.error(error);
      },
    );
  });

  const backgroundStyle = {
    backgroundColor: isDarkMode ? Colors.darker : Colors.lighter,
  };

  return (
    <SafeAreaView style={backgroundStyle}>
      <StatusBar
        barStyle={isDarkMode ? 'light-content' : 'dark-content'}
        backgroundColor={backgroundStyle.backgroundColor}
      />
      <ScrollView
        contentInsetAdjustmentBehavior="automatic"
        style={backgroundStyle}>
        <Header />
        <View
          style={{
            backgroundColor: isDarkMode ? Colors.black : Colors.white,
          }}>
          <Section title="Step One">
            Edit <Text style={styles.highlight}>App.tsx</Text> to change this
            screen and then come back to see your edits.
          </Section>
          <Section title="See Your Changes">
            <ReloadInstructions />
          </Section>
          <Section title="Debug">
            <DebugInstructions />
          </Section>
          <Section title="Learn More">
            Read the docs to discover what to do next:
          </Section>
          <LearnMoreLinks />
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  sectionContainer: {
    marginTop: 32,
    paddingHorizontal: 24,
  },
  sectionTitle: {
    fontSize: 24,
    fontWeight: '600',
  },
  sectionDescription: {
    marginTop: 8,
    fontSize: 18,
    fontWeight: '400',
  },
  highlight: {
    fontWeight: '700',
  },
});

export default App;
