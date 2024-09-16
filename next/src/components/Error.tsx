import { Card, CardContent, Container } from '@mui/material'

const Error = () => {
  return (
    <Container maxWidth="sm">
      <Card sx={{ p: 3, mt: 8, backgroundColor: '#EEEEEE' }}>
        <CardContent sx={{ lineHeight: 2 }}>
          現在、システムでエラーが発生しています。しばらくしてから再度お試しください。
        </CardContent>
      </Card>
    </Container>
  )
}

export default Error
