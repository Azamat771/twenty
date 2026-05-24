// Iframe-страница "Почта — настройки" (форк ru-translations).
// Аналог EmailInboxPage, redirectUri указывает на /leads/settings.

import { styled } from '@linaria/react';
import { useEffect, useState } from 'react';

import { getTokenPair } from '@/apollo/utils/getTokenPair';
import { REACT_APP_SERVER_BASE_URL } from '~/config';

const EMAIL_SETTINGS_URL =
  'https://crm-hooks.center-guarantee.ru/leads/settings';

const StyledContainer = styled.div`
  display: flex;
  flex: 1;
  height: 100%;
  width: 100%;
`;

const StyledIframe = styled.iframe`
  border: none;
  flex: 1;
  height: 100%;
  width: 100%;
`;

const StyledMessage = styled.div`
  align-items: center;
  display: flex;
  flex: 1;
  height: 100%;
  justify-content: center;
  width: 100%;
`;

export const EmailSettingsPage = () => {
  const [src, setSrc] = useState<string | null>(null);
  const [errorMessage, setErrorMessage] = useState<string | null>(null);

  useEffect(() => {
    let cancelled = false;

    const fetchSsoToken = async () => {
      const tokenPair = getTokenPair();
      const accessToken = tokenPair?.accessOrWorkspaceAgnosticToken?.token;

      if (accessToken === undefined || accessToken === null) {
        if (!cancelled) {
          setErrorMessage('Не удалось получить токен сессии');
        }
        return;
      }

      try {
        const response = await fetch(
          `${REACT_APP_SERVER_BASE_URL}/api/sso/handoff`,
          {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
              Authorization: `Bearer ${accessToken}`,
            },
            body: JSON.stringify({ redirectUri: EMAIL_SETTINGS_URL }),
          },
        );

        if (!response.ok) {
          throw new Error(`HTTP ${response.status}`);
        }

        const data: { ssoToken: string; redirectUri: string } =
          await response.json();

        if (!cancelled) {
          setSrc(`${data.redirectUri}?sso=${data.ssoToken}`);
        }
      } catch (error) {
        if (!cancelled) {
          setErrorMessage(
            error instanceof Error ? error.message : 'Ошибка SSO',
          );
        }
      }
    };

    fetchSsoToken();

    return () => {
      cancelled = true;
    };
  }, []);

  if (errorMessage !== null) {
    return <StyledMessage>Ошибка загрузки: {errorMessage}</StyledMessage>;
  }

  if (src === null) {
    return <StyledMessage>Загрузка...</StyledMessage>;
  }

  return (
    <StyledContainer>
      <StyledIframe
        src={src}
        title="Почта — настройки"
        sandbox="allow-scripts allow-forms allow-popups allow-same-origin"
        allow="encrypted-media"
        allowFullScreen
      />
    </StyledContainer>
  );
};
