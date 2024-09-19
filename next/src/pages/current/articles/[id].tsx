import ArticleIcon from '@mui/icons-material/Article'
import ChevronLeftIcon from '@mui/icons-material/ChevronLeft'
import SettingsIcon from '@mui/icons-material/Settings'
import {
  Avatar,
  Box,
  Container,
  Typography,
  Card,
  List,
  ListItem,
  ListItemText,
  Tooltip,
  IconButton,
} from '@mui/material'
import camelcaseKeys from 'camelcase-keys'
import type { NextPage } from 'next'
import Link from 'next/link'
import { useRouter } from 'next/router'
import useSWR from 'swr'
import Error from '@/components/Error'
import Loading from '@/components/Loading'
import MarkdownText from '@/components/MarkdownText'
import { useUserState } from '@/hooks/useGlobalState'
import { useRequireSignedIn } from '@/hooks/useRequireSignedIn'
import { styles } from '@/styles'
import { fetcher } from '@/utils'

type CurrentArticleProps = {
  title: string
  content: string
  createdAt: string
  status: string
}

const MyArticleDetail: NextPage = () => {
  useRequireSignedIn()
  const [user] = useUserState()
  const router = useRouter()
  const url = process.env.NEXT_PUBLIC_API_BASE_URL + '/current/articles/'
  const { id } = router.query

  const { data, error } = useSWR(
    user.isSignedIn && id ? url + id : null,
    fetcher,
  )

  if (error) return <Error />
  if (!data) return <Loading />

  const article: ArticleProps = camelcaseKeys(data)

  return (
    <Box
      css={styles.pageMInHeight}
      sx={{
        backgroundColor: '#EDF2F7',
        pg: 6,
      }}
    >
      <Box
        sx={{
          display: { xs: 'block', lg: 'none' },
          backgroundColor: 'white',
          borderTop: '0.5px solid #acbcc7',
          height: 56,
          color: '#6e7b85',
        }}
      >
          <Container
            maxWidth="sm"
            sx={{
              display: 'flex',
              justifyContent: 'space-around',
              alignItems: 'center',
              height: '100%',
            }}
          >
            <Box sx={{ display: 'flex', gap: '0 8px'}}>
              <SettingsIcon />
              <Typography
                component="p"
                sx={{ mr: 1, fontSize: { xs: 14, sm: 16 } }}
              >
                ステータス: {article.status}
              </Typography>
            </Box>
            <Box sx={{ display: 'flex', gap: '0 8px'}}>
              <SettingsIcon />
              <Typography
                component="p"
                sx={{ mr: 1, fontSize: { xs: 14, sm: 16 } }}
              >
                公開: {article.createdAt}
              </Typography>
            </Box>
          </Container>
      </Box>
      <Container maxWidth="lg">
        <Box sx={{ pt: 6, pb: 3 }}>
          <Box
            sx={{
              display: 'flex',
              alignItems: 'center',
              gap: '0 8px',
              m: 'auto'
            }}
          >
            <Box sx={{ width: 40, height: 40 }}>
              <Link href="/current/articles">
                <Avatar>
                  <Tooltip title="記事の管理に戻る">
                    <IconButton sx={{ backgroundColor: '#DDDDDD' }}>
                      <ChevronLeftIcon sx={{ color: '#99AAB6' }}/>
                    </IconButton>
                  </Tooltip>
                </Avatar>
              </Link>
            </Box>

          </Box>
        </Box>
      </Container>
    </Box>
  )
}

export default MyArticleDetail
