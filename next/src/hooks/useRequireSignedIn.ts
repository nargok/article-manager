import { useRouter } from 'next/router'
import { useEffect } from 'react'
import { useUserState, useSnackbarState } from '@/hooks/useGlobalState'

export function useRequireSignedIn() {
  const router = useRouter()
  const [user] = useUserState()
  const [, setSnackBar] = useSnackbarState()

  useEffect(() => {
    if (user.isFetched && !user.isSignedIn) {
      setSnackBar({
        message: 'サインインしてください',
        severity: 'error',
        pathname: '/sign_in',
      })
      router.push('/sign_in')
    }
  }, [user, router, setSnackBar])
}
