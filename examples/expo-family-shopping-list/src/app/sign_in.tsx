import React from 'react'
import { Alert, View } from 'react-native'
import { Button } from 'react-native-paper'
import EmailPasswordForm from '../components/EmailPasswordForm'
import { Link, router } from 'expo-router'
import { useAuthActions } from '../components/AuthProvider'
import AppLogo from '../components/AppLogo'
import { SafeAreaView } from 'react-native-safe-area-context'



export default function SignIn() {
  const { signIn } = useAuthActions()
  const signInWithEmail = async (email: string, password: string) => {
    const { error } = await signIn({
      email: email,
      password: password,
    })
    if (error) Alert.alert(error.message)
    else router.replace('/')
  }

  return (
    <SafeAreaView style={{ marginHorizontal: 16, gap: 12 }}>
      <View style={{ alignItems: 'center' }}>
        <AppLogo height={200} width={200} />
      </View>
      <EmailPasswordForm
        submitText="Sign in"
        onSubmit={signInWithEmail}
        />
      <Link href="/sign_up" replace asChild>
        <Button mode="text">
          I don't have an account
        </Button>
      </Link>
    </SafeAreaView>
  )
}
